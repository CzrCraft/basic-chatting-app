module.exports = {
    port: process.env.NODE_PORT || 3000,
    mongoose: {
        Promise: require('bluebird'), //mongoose promise library
        connection: 'mongodb://127.0.0.1:27017/TestBaza1',
    },
    jwt: {
        secret: '073EE8894569835F62363485E444620C3A2C21A5B6F9DC2BC3F75726E6EC6342', //secret key for jwt auth
    },
    winston: {
        writeToConsole: true, //enable writing to console
        writeToFile: true, //enable writing to file

        file: { //file writing config
            filename: `./app/logs/${(new Date()).getDate()}-${(new Date()).getMonth()}-${(new Date()).getFullYear()}.log`, //where the log file will be written
            json: false,
            //... for more config options see https://github.com/winstonjs/winston/blob/master/docs/transports.md#file-transport
        },
        console: {
            colorize: true,
            //... for more config options see https://github.com/winstonjs/winston/blob/master/docs/transports.md#console-transport
        },
    },
    errorFormatting: (param, msg, value, location) => msg, // https://github.com/ctavan/express-validator#legacy-api
};