local token = 1

mp.observe_property("audio-out-detected-device", "native", function(_, v)
  if v and token > 0 then
    print("selected-device :: " .. v)
    if v == "AppleUSBAudioEngine:C-Media Electronics Inc.:SB Easy Record/SB Connect Hi-Fi:090804000001:2,1" then
      print("reset volume to " .. 10)
      mp.set_property_native("volume", 20)
    end
    token = token - 1
  else
    print("selected-device :: (null)")
  end
end)
