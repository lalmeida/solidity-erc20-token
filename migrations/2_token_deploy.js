const ERC20FancyToken = artifacts.require("ERC20FancyToken");

module.exports = function (deployer) {
  deployer.deploy(ERC20FancyToken, "Foo Bar Token", "FOO", 100_000_000);
};
