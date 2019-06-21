const registerMeter = artifacts.require("./registerMeter.sol");

module.exports = function(deployer) {
  deployer.deploy(registerMeter);
};
