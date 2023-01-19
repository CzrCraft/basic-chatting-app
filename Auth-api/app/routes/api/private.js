const privateRouter = require('express').Router();

const userController = require('../../controllers/user');
const privateChatsController = require("../../controllers/privateChats");

privateRouter.get('/user', userController.info);
privateRouter.post('/user', userController.update);
privateRouter.delete('/user', userController.delete);
privateRouter.post('/user/checkpassword', userController.checkPassword);



privateRouter.post('/chat/private/createRoom', privateChatsController.createRoom);
privateRouter.post("/chat/private/checkForRoom", privateChatsController.checkForACurrentRoom);
privateRouter.post("/chat/private/sendMessage", privateChatsController.sendMessage);
privateRouter.post("/chat/private/getRoomID", privateChatsController.getRoomID);
privateRouter.post("/chat/private/getMessages", privateChatsController.getMessages);
privateRouter.post("/chat/private/getUserEmail", privateChatsController.getUserEmail);

privateRouter.post("/private/dummy", userController.dummy);


module.exports = privateRouter;