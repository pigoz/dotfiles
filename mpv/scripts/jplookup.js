"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
var SHELL = '/bin/sh';
var showLoading = false;
var defaultOptions = {
    fs: 14,
    border: 1.0,
    color: 'FFFFFF',
    borderColor: '000000',
};
function clearass() {
    mp.set_osd_ass(0, 0, '{}');
}
function ass(message, opts) {
    var options = __assign({}, defaultOptions, opts);
    var style = [
        "{\\fs" + options.fs + "}",
        "{\\1c&H" + options.color + "&}",
        "{\\bord" + options.border + "}",
        "{\\3c&H" + options.borderColor + "&}",
    ].join('');
    mp.set_osd_ass(0, 0, "" + style + message);
}
function handler(_prop, text) {
    if (!text) {
        clearass();
        return;
    }
    if (showLoading) {
        ass('読み込み中・・・', { fs: 10 });
    }
    var result = lookup(text).map(function (x) { return x.lemma + " (" + x.reading + ") - " + x.definition; });
    if (result.length > 0) {
        ass("" + result.join('\\N'), {});
    }
    else {
        clearass();
    }
}
var active = false;
var eos = { t: 'EOS' };
var pos = function (l, v) { return ({
    t: 'POS',
    l: l,
    v: v,
}); };
function removeSpeaker(text) {
    return text
        .replace(/（[^（）]*）/, '')
        .replace(/\([^()]*\)/, '')
        .trim();
}
function mecab(text) {
    var t = mp.utils.subprocess({
        args: [SHELL, '-c', "echo '" + text + "' | mecab"],
    });
    return t.stdout
        .trim()
        .split('\n')
        .map(function (x) {
        var tuple = x.split('\t');
        var l = tuple[0];
        var v = tuple[1] ? tuple[1].split(',') : [];
        return l === 'EOS' ? eos : pos(l, v);
    });
}
function jisho(lemma) {
    var endpoint = 'https://jisho.org/api/v1/search/words';
    var t = mp.utils.subprocess({
        args: [
            '/usr/bin/curl',
            '-s',
            '-G',
            endpoint,
            '--data-urlencode',
            "keyword=" + lemma,
        ],
    });
    var result = JSON.parse(t.stdout.trim());
    return result.data[0].senses
        .map(function (x) { return x.english_definitions[0]; })
        .join(' – ');
}
function dict(lemma) {
    var t = mp.utils.subprocess({
        args: ['/usr/local/bin/myougiden', '--color=no', '-t', lemma],
    });
    var result = t.stdout.trim().split('\n')[0];
    if (!result) {
        return '–';
    }
    return result.split('\t')[2].split('|')[0];
}
function lookup(text) {
    return mecab(removeSpeaker(text))
        .filter(function (x) { return x.t === 'POS'; })
        .filter(function (x) { return !!x.l.match(/[\u4E00-\u9FAF]/); })
        .map(function (x) { return ({ lemma: x.v[6], reading: x.v[7], definition: dict(x.v[6]) }); });
}
function subanalyze() {
    if (active) {
        mp.unobserve_property(handler);
        clearass();
        active = false;
    }
    else {
        mp.observe_property('sub-text', 'string', handler);
        active = true;
    }
}
mp.add_key_binding('x', 'toggle', subanalyze);
function testhandler() {
    lookup('小さな約束だった').forEach(function (x) {
        return mp.msg.error(x.lemma + ": " + x.definition);
    });
}
//# sourceMappingURL=jplookup.js.map