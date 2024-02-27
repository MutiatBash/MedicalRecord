
async function main() {
	const [deployer] = await ethers.getSigners();
	console.log(`Deployer's account: ${deployer?.address}`);

	const MedicalRecordFactory = await ethers.getContractFactory(
		"MedicalRecordFactory"
	);
	const medicalRecordFactory = await MedicalRecordFactory.deploy();

	console.log(`Contract address: ${medicalRecordFactory.target}`);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
