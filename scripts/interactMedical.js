const { ethers } = require("hardhat");
const { JsonRpcProvider } = require("@ethersproject/providers");
const contractAbi = require("../abi.json");

async function main() {
	const provider = new JsonRpcProvider(
		"https://polygon-mumbai.g.alchemy.com/v2/demo"
	);
	const signer = await provider.getSigner(); 

	const contractAddress = "0xdF4E6F637FFBdF87c13C65191C617E9275bb06C0";
	const contract = new ethers.Contract(contractAddress, contractAbi, signer); 

	try {
		const record = await contract.createMedicalRecord(
			"0xD7E2286E40c0e4755d86a1d75C7094e48bAC56Fd",
			"Amy Blessing",
			25,
			"22-01-1998",
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
