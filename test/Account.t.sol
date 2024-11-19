// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";

import "@era-system-contracts/libraries/SystemContractsCaller.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "src/AAFactory.sol";
import "src/Account.sol";

contract AccountTest is Test {
    function setUp() public {
        // uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address owner = vm.envAddress("OWNER");

        // Read artifact file and get the bytecode hash
        string memory artifact = vm.readFile("zkout/Account.sol/Account.json");
        bytes32 accountBytecodeHash = vm.parseJsonBytes32(artifact, ".hash");

        console.logString("Account Bytecode hash:");
        console.logBytes32(accountBytecodeHash);
        bytes32 salt = "1234";

        AAFactory factory = new AAFactory(accountBytecodeHash);

        console.logString("Factory deployed at:");
        console.logAddress(address(factory));

        string memory factoryArtifact = vm.readFile("zkout/AAFactory.sol/AAFactory.json");
        bytes32 factoryBytecodeHash = vm.parseJsonBytes32(factoryArtifact, ".hash");
        console.log("Factory Bytecode hash: ");
        console.logBytes32(factoryBytecodeHash);

        factory.deployAccount(salt, owner);
    }

    function testAccount() public {}

    // function testFuzz_SetNumber(uint256 x) public {
    //     counter.setNumber(x);
    //     assertEq(counter.number(), x);
    // }
}
