const { asyncValidationErrors } = require('express-validator/check');
const utils = require('../utils');
const config = require('../../config');
const _ = require('lodash');

const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/PrivateRoom');
const PrivateRoom = require('../models/PrivateRoom');


module.exports.createChat = async(req, res) => {
    let(firstAccountID, secondAccountID) = req.body;

    try{
        await req.asyncValidationErrors();
        roomID = ''.concat(firstAccountID, secondAccountID,);
        const Room = new PrivateRoom({roomID});
        await Room.save();
        res.json({success: true});
    }catch(error){
        print("Private room creation failed!");
        print(error);
    }
}

module.exports.sendMessage = async(req, res) =>{

}