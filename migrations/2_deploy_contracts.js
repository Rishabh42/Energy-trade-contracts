const registerMeter = artifacts.require("./registerMeter.sol");
const orderBook = artifacts.require("./orderBook.sol");

module.exports = function(deployer) {
  deployer.deploy(registerMeter);
  deployer.deploy(orderBook);
};
