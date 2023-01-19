const mongoose = require("mongoose");

const privateRoomSchema = new mongoose.Schema({
    _id: {type: String, required: true},
    date: {type: Date, default: Date.now},
    user1: {type: String, requierd: true},
    user2: {type: String, required: true},
    messages: {type: Array},
})

module.exports = mongoose.model("Room", privateRoomSchema, "privateRooms");