var QuestionPosting = artifacts.require("QuestionPosting");

module.exports = function(deployer) {
  deployer.deploy(QuestionPosting)
};