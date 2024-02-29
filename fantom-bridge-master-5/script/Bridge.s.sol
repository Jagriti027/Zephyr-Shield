// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import "../src/Bridge.sol";
import "../src/BridgeToken.sol";

contract BridgeScript is Script {
    function setUp() public {}

    function run() public {
		uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
		vm.startBroadcast(deployerPrivateKey);

		// address bridge_address = vm.computeCreateAddress(vm.envAddress("ADDRESS"), vm.getNonce(vm.envAddress("ADDRESS")));
		// address token_address = vm.computeCreateAddress(vm.envAddress("ADDRESS"), vm.getNonce(vm.envAddress("ADDRESS"))+1);

		// console2_log_StdUtils(bridge_address);
		// console2_log_StdUtils(token_address);

		// console2.log("Bridge address: %s", bridge_address);
		// console2.log("Token address: %s", token_address);

		Bridge bridge = new Bridge();
		BridgeToken token = new BridgeToken();

		console2.log("Bridge address: %s", address(bridge));
		console2.log("Token address: %s", address(token));

		token.setMaxSupply(100000);
		token.ownerMint(vm.envAddress("ADDRESS"), 1000);
		
		
		token.setAdmin(address(bridge));
		bridge.addToken(address(token));
		bridge.bridgeSent(address(token), 10, vm.envAddress("ADDRESS"));

        vm.stopBroadcast();
    }
}
