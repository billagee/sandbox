// Makes iTunes skip back one track.
//
// Run in Script Editor, or with:
//    $ osascript itunes-backTrack.js

iTunes = Application('iTunes')
state = iTunes.playerState()
// Console msgs show up in the Messages tab of the bottom view:
console.log("playerState: " + state)
iTunes.backTrack()

