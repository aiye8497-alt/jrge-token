//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/JrgeToken.sol";

contract DeployJrgeToken is Script {
    function run() external {
        vm.startBroadcast();
        JrgeToken token = new JrgeToken();
        vm.stopBroadcast();
    }
}