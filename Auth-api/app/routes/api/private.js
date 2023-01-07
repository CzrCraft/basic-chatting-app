const privateRouter = require('express').Router();

const userController = require('../../controllers/user');
const privateChatsController = require("../../controllers/privateChats");

privateRouter.get('/user', userController.info);
privateRouter.post('/user', userController.update);
privateRouter.delete('/user', userController.delete);
privateRouter.post('/user/checkpassword', userController.checkPassword);



privateRouter.post("/chat/private/createRoom", privateChatsController.createChat);
privateRouter.post("/chat/private/sendMessage", privateChatsController.sendMessage);

module.exports = privateRouter;