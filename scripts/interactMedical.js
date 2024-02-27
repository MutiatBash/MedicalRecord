const { ethers } = require("hardhat");
const { JsonRpcProvider } = require("@ethersproject/providers");
const { privateKey } = require("../privateKeys.json");
const contractAbi = require("../abi.json");

async function main() {
	const provider = new JsonRpcProvider("https://rpc.ankr.com/polygon_mumbai");

	const wallet = new ethers.Wallet(privateKey, provider);
	const contractAddress = "0xA67054D05aA74e6C00442Ded2001B251f67196E5";
	const contract = new ethers.Contract(contractAddress, contractAbi, wallet);

	try {
		
		const managementAddress = await contract.hospitalManagement();
		console.log("Hospital Management Address:", managementAddress);


		const record = await contract.createMedicalRecord(
			"0xD7E2286E40c0e4755d86a1d75C7094e48bAC56Fd",
			"Blessing",
			25,
			"January 22 1989",
			"Female",
			"Malaria"
		);

		await record.wait();
		console.log("A new patient record was created");
		console.log("Transaction Hash:", record.hash);
	} catch (err) {
		console.error(err);
	}
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});



