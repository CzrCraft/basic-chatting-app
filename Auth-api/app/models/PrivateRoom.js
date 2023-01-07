const mongoose = require("mongoose");

const privateRoomSchema = new mongoose.Schema({
    roomID: {type: String, required: true},
    date: {type: Date, default: Date.now},
    messages: {type: Array},
})

module.exports = mongoose.model("RoomPage", privateRoomSchema, "privateRooms");