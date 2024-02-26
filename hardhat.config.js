require("@nomicfoundation/hardhat-toolbox");
const { projectId, privateKey } = require("./secret.json");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
	solidity: "0.8.19",
	networks: {
		mumbai: {
			url: "https://rpc-mumbai.maticvigil.com/",
			accounts: [privateKey],
		},
	},
};
