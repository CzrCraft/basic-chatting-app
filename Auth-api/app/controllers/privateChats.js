const { asyncValidationErrors } = require('express-validator/check');
const utils = require('../utils');
const config = require('../../config');
const _ = require('lodash');

const express = require('express');
const jwt = require('jsonwebtoken');
const PrivateRoom = require('../models/PrivateRoom');
const User = require('../models/User');
const { first, update } = require('lodash');
// module.exports.getUserInfo = async(req,res) =>{
//     const { _id } = req.body;
//     try {
//         const user = await User.findById(_id);
//         utils.info(`User '${user.first_name} ${user.last_name}' got info!`);
//         // res.json({success: true, user});    
//         return user;    
//     } catch(error) {
//         utils.error(error);
//         return null;
//     }
// }

module.exports.getUserEmail = async(req, res) =>{
    try{
        let {userID} = req.body;
        await User.findById(userID).exec(function(err, result){
            let userEmail = result.email;
            console.log(userEmail);
            res.json({success: true, userEmail});
        });
    }catch(error){
        console.log(error);
        res.json({success: false, error})
    }
}

module.exports.getMessages = async(req, res) =>{
    try{
        let{userID} = req.body;
        console.log(userID);
        let room1Messages;
        let room1 = await PrivateRoom.findOne({user1: userID, date:{$gte: new Date().setUTCHours(0,0,0,0), $lte: new Date().setUTCHours(23,59,59,999)}}).then(function(result, err){if(err == null){room1Messages = result;}else{room1Messages=err;console.log(err)}});
        let room2Messages;
        let room2 = await PrivateRoom.findOne({user2: userID, date:{$gte: new Date().setUTCHours(0,0,0,0), $lte: new Date().setUTCHours(23,59,59,999)}}).then(function(result, err){if(err == null){room2Messages = result;}else{room2Messages=err;console.log(err)}});
        console.log(room1Messages);
        console.log(room2Messages);
        if(room1Messages != null && room2Messages == null){
            console.log(room1Messages.messages);
            res.json({success: true, messages: room1Messages.messages});
        }else if(room1Messages != null && room2Messages != null){
            room1Messages = room1Messages.messages;
            room2Messages = room2Messages.messages;
            for(let i = 0; i < room2Messages.length; i++){
                room1Messages.push(room2Messages[i]);
            }
            console.log(room1Messages);
            console.log(room2Messages);
            res.json({success: true, messages: room1Messages});
        }else if(room1Messages ==  null && room2Messages != null){
            console.log(room2Messages.messages);
            res.json({success: true, messages: room2Messages.messages});
        }
    }catch (error){
        console.log(error);
        res.json({success: false, error})
    }
}


module.exports.createRoom = async(req, res) => {
    try{
        let{creatorAccountID, secondAccountID} = req.body;
        utils.info(creatorAccountID);
        utils.info(secondAccountID);
        //utils.info(creatorAccountInfo);
        //utils.info("Attempting to create a private room");
        creatorAccountID_buffer = creatorAccountID.match(/.{2}/g);;
        creatorAccountID_date_h = creatorAccountID_buffer[0].toString() + creatorAccountID_buffer[1].toString() + creatorAccountID_buffer[2].toString()  + creatorAccountID_buffer[3].toString() ;
        console.log(parseInt(creatorAccountID_date_h, 16));
        secondAccountID_buffer = secondAccountID.match(/.{2}/g);;
        secondAccountID_buffer_h = secondAccountID_buffer[0].toString() + secondAccountID_buffer[1].toString() + secondAccountID_buffer[2].toString()  + secondAccountID_buffer[3].toString() ;
        console.log(parseInt(secondAccountID_buffer_h, 16));
        if(parseInt(creatorAccountID_date_h, 16) < parseInt(secondAccountID_buffer_h, 16)){
            var x = creatorAccountID;
            creatorAccountID = secondAccountID;
            secondAccountID = x;
        }


        await req.asyncValidationErrors();
        roomID = ''.concat(creatorAccountID, secondAccountID);
        utils.info("1");
        const date = new Date();
        const Room = new PrivateRoom({
            _id: roomID.toString() + date.getFullYear().toString() + date.getMonth().toString() + date.getDate().toString(),
            user1: creatorAccountID,
            user2: secondAccountID,
        });
        utils.info("2");
        utils.info(roomID);
        await Room.save();
        res.json({success: true});
    }catch(error){
        res.json({success: false});
        utils.info("Private room creation failed!");
        utils.info(error);
    }
}

module.exports.checkForACurrentRoom = async(req, res) =>{
    try{
        let roomID = req.body;
        await req.asyncValidationErrors();
        const PrivateRoom = PrivateRoom.findById(roomID);
        res.json({success:true});
    }catch(error){
        res.json({success:false});
        print("Failed to check for a private room");
        print(error);
    }
}

module.exports.getRoomID = async(req, res) =>{
    try{
        let{firstAccountID, secondAccountID} = req.body;
        console.log(firstAccountID);
        console.log(secondAccountID);
        var reqDocument;
        const date = new Date();
        if(parseInt(firstAccountID, 16) < parseInt(secondAccountID, 16)){
            var x = firstAccountID;
            firstAccountID = secondAccountID;
            secondAccountID = x;
        }
        //let privateRoom = await PrivateRoom.findById().sort({_id: -1}).exec().then(function(result, err){console.log(result); reqDocument = result});
        console.log(firstAccountID.toString() + secondAccountID.toString() + date.getFullYear().toString() + date.getMonth().toString() + date.getDate().toString());
        res.json({success:true, _id: firstAccountID.toString() + secondAccountID.toString() + date.getFullYear().toString() + date.getMonth().toString() + date.getDate().toString()});
    }catch(error){
        utils.error(error);
        res.json({success:false, error});
    }
}

module.exports.sendMessage = async(req, res) =>{
    // let _id = req.params["_id"];
    // let senderID = req.params["senderID"];
    // let message = req.params["message"];
    try{
        let{_id, senderID, message} = req.body;
        console.log("Trying to send a message!");
        console.log(_id);
        console.log(message);
        //let privateRoom = await PrivateRoom.findById(_id).exec().then(function(result, err){reqDocument = result});
        console.log("bla");
        //await updated_privateRoom.save();
        await PrivateRoom.findByIdAndUpdate(_id, {$push: {messages: [senderID.toString(), message.toString()]}});
        res.json({success: true});
    }catch(error){
        utils.error(error);
        res.json({success:false, error});
    }
}
