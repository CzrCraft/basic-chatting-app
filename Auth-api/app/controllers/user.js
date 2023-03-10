const { asyncValidationErrors } = require('express-validator/check');
const utils = require('../utils');
const config = require('../../config');
const _ = require('lodash');

const express = require('express');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

//POST
module.exports.register = async (req, res) => {
    let { first_name, last_name, email, password } = req.body;
    try {
        await req.asyncValidationErrors();
        const user = new User({
            first_name,
            last_name,
            email,
            password
        });
        await user.save();
        res.json({success: true});
        utils.info(`User '${first_name} ${last_name}' registered!`);
    } catch(error) {
        res.json({success: false, error});
        utils.info("Registration attempt failed");
        utils.info(error);
        utils.info("Provided info:");
        utils.info(email);
        utils.info(password);
    }
};

//POST
module.exports.login = async (req, res) => {
    utils.info("Login attempted!")
    let { email, password } = req.body;
    try {
        await req.asyncValidationErrors();
        const user = await User.findOne({email, password}, {password: 0});
        const token = jwt.sign(JSON.parse(JSON.stringify(user)), config.jwt.secret, config.jwt.options);
        res.json({
            success: true,
            user,
            token,
        });
        utils.info(email + " logged in!");
    } catch(error) {
        utils.info("Login failed");
        utils.info(error);
        utils.info(email);
        utils.info(password);
        res.json({success: false, error});
    }

};

//GET
module.exports.info = async (req, res) => {
    /*
    We could use res.locals to serve the user data but when the data changes it will serve the old data from the JWT token
     */
    const { _id } = res.locals.user;
    try {
        const user = await User.findById(_id);
        utils.info(`User '${user.first_name} ${user.last_name}' got info!`);
        res.json({success: true, user});        
    } catch(error) {
        utils.error(error);
        res.json({success: false});
    }
};

//POST
module.exports.update = async (req, res) => {
    let data = req.body;

    //remove all the dangerous fields from the request body
    data = _.reduce(data, (result, val, key) => {
        const guarded = ['_id', '__v', 'created_at']; //all the fields that are dangerous and *must* be removed from the request body
        if (guarded.indexOf(key) === -1) result[key] = val;
        return result;
    }, {});

    const { user } = res.locals;
    //set updated_at date
    const set = Object.assign(data, {'meta.updated_at': new Date});
    try {
        await User.findByIdAndUpdate(user._id, {$set: set});
        console.log(set);
        utils.info(`User '${user.first_name} ${user.last_name}' updated!`);
        res.json({success: true});
    } catch(error) {
        res.json({success: false, error});
    }
};

//POST
module.exports.checkPassword = async (req,res) => {
    const { password } = req.body;
    try {
        const user = await User.findById(res.locals.user._id);
        res.json({success: (user.password === password)});
    } catch(error) {
        res.json({success: false, error});
    }
};

//DELETE
module.exports.delete = async (req, res) => {
    const { user } = res.locals;
    try {
        await User.findByIdAndRemove(user._id);
        utils.info(`User '${user.first_name} ${user.last_name}' deleted!`);
        res.json({success: true});
    } catch(error) {
        res.json({success: false, error});
    }
};


module.exports.getUserID = async(req, res) =>{
    /*
    We could use res.locals to serve the user data but when the data changes it will serve the old data from the JWT token
     */
    const {email} = req.body;
    try {
        var reqDocument;
        var user = await User.findOne({email: email}).exec().then(function(result, err){console.log(result); reqDocument=result});
        res.json({success:true, _id: reqDocument._id}); 
        // utils.info(reqDocument["email"]);
        //res.json({success: true, _id: user["_id"]});        
    } catch(error) {
        utils.error(error);
        res.json({success: false});
    }
}

module.exports.dummy = async(req, res) =>{
    try {
        res.json({success: true});        
    } catch(error) {
        utils.error(error);
    }
}