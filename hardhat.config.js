require("@nomicfoundation/hardhat-toolbox");
const { privateKey } = require("./privateKeys.json");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
	solidity: "0.8.19",
	networks: {
		mumbai: {
			url: "https://rpc.ankr.com/polygon_mumbai",
			accounts: [privateKey],
		},
	},
};
