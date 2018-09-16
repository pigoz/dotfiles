"use strict";
var AUDIO_THRESHOLD = 0.25;
var IMAGE_WIDTH = 480;
var IMAGE_DELAY_PERCENT = 0.08;
var ANKI_DECK_NAME = 'sub2srs';
var ANKI_NOTE_TYPE = 'Japanese sub2srs';
var ANKI_TAG_NAME = 'sub2srs';
var ANKI_MEDIA_COLLECTION = '/Users/pigoz/Library/Application Support/Anki2/User 1/collection.media';
var FFMPEG = 'ffmpeg';
var CURL = 'curl';
function sts(ts) {
    var date = new Date(0);
    date.setSeconds(ts);
    var s = date.toISOString();
    return s.slice(11, 23);
}
function mktemp(extension) {
    var t = mp.utils.subprocess({
        args: ['mktemp', '-t', 'sub2srs'],
    });
    return t.stdout.trim() + "." + extension;
}
function cutaudio(path, aid, start, end) {
    var ss = sts(start - AUDIO_THRESHOLD);
    var duration = sts(end - start + AUDIO_THRESHOLD);
    var output = mktemp('mp3');
    var command = [
        FFMPEG,
        '-y',
        '-ss',
        ss,
        '-i',
        path,
        '-t',
        duration,
        '-map',
        "0:a:" + (aid - 1),
        output,
    ];
    var t = mp.utils.subprocess({ args: command });
    if (t.status === 0) {
        return output;
    }
    return '';
}
function screenshot(path, start, end) {
    var ss = sts(start + (end - start) * IMAGE_DELAY_PERCENT);
    var output = mktemp('jpg');
    var command = [
        FFMPEG,
        '-y',
        '-ss',
        ss,
        '-i',
        path,
        '-vcodec',
        'mjpeg',
        '-vframes',
        '1',
        '-filter:v',
        "scale=" + IMAGE_WIDTH + ":-1",
        output,
    ];
    var t = mp.utils.subprocess({ args: command });
    if (t.status === 0) {
        return output;
    }
    return '';
}
function ankiapi(method, params) {
    var hostname = 'http://127.0.0.1:8765';
    var data = JSON.stringify({ action: method, version: 6, params: params });
    var command = [
        CURL,
        hostname,
        '--silent',
        '--X',
        'POST',
        '--data',
        data,
    ];
    mp.msg.warn(command.join(' '));
    var t = mp.utils.subprocess({ args: command });
    mp.msg.warn(JSON.stringify(t));
    var reply = JSON.parse(t.stdout);
    return reply;
}
function mv(src, dst) {
    mp.utils.subprocess({ args: ['mv', src, dst] });
}
function addtoanki(source, start, audio, image, line) {
    var caudio = mp.utils.join_path(ANKI_MEDIA_COLLECTION, basename(audio));
    var cimage = mp.utils.join_path(ANKI_MEDIA_COLLECTION, basename(image));
    var fields = {
        Source: source,
        Time: sts(start),
        Sound: "[sound:" + basename(audio) + "]",
        Image: "<img src=\"" + basename(image) + "\" />",
        Line: line,
    };
    ankiapi('changeDeck', { cards: [], deck: ANKI_DECK_NAME });
    var res = ankiapi('addNote', {
        note: {
            deckName: ANKI_DECK_NAME,
            modelName: ANKI_NOTE_TYPE,
            fields: fields,
            tags: [ANKI_TAG_NAME],
        },
    });
    if (res.result && !res.error) {
        mv(audio, caudio);
        mv(image, cimage);
    }
}
function basename(path) {
    var x = mp.utils.split_path(path);
    return x[x.length - 1];
}
function sub2srs() {
    var text = mp.get_property('sub-text');
    var path = mp.get_property('path');
    var aid = mp.get_property_number('aid') || 1;
    if (!path) {
        mp.msg.warn('no path available');
        return;
    }
    if (!text) {
        mp.msg.warn('no subtitle is focused');
        return;
    }
    var start = mp.get_property_number('sub-start');
    var end = mp.get_property_number('sub-end');
    if (!start || !end) {
        mp.msg.warn('cannot retrieve sub timings');
        return;
    }
    var audio = cutaudio(path, aid, start, end);
    var image = screenshot(path, start, end);
    addtoanki(basename(path), start, audio, image, text.replace(/\n|\r/g, ' '));
}
mp.add_key_binding('b', 'sub2anki', sub2srs);
//# sourceMappingURL=sub2srs.js.map