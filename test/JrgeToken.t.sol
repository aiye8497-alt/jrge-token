//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/JrgeToken.sol";

contract JrgeTokenTest is Test {
    JrgeToken public token;
    
    function setUp() public {
        token = new JrgeToken();
    }

    function testMint() public {
        address to = address(0x1);
        uint256 amount = 1000;
        token.mint(to, amount);
        assertEq(token.balanceOf(to), amount);
    }
    /*DEPLOYMENT TEST*/
    function testInitialSupply() public {
        uint256 initialSupply = 1000000 * 10 ** token.decimals();
        assertEq(token.totalSupply(), initialSupply);
        assertEq(token.balanceOf(address(this)), initialSupply);
    }
    /*TRANSFER TEST*/
    function testTransfer() public {
        address to = address(0x1);
        uint256 amount = 1000;
        token.transfer(to, amount);
        assertEq(token.balanceOf(to), amount);
        assertEq(token.balanceOf(address(this)), token.totalSupply() - amount);
    }
    /*MINTING TEST*/
    function testMinting() public {
        address to = address(0x1);
        uint256 amount = 1000;
        token.mint(to, amount);
        assertEq(token.balanceOf(to), amount);
        assertEq(token.totalSupply(), 1000000 * 10 ** token.decimals() + amount);
    }
    function testNonOwnerCannotMint() public{
        vm.prank(address(0x2));
        vm.expectRevert("Ownable: caller is not the owner");
        token.mint(address(0x2), 1000);
    }
    /*PAUSE TEST*/
    function testPause() public {
        token.pause();
        assertTrue(token.paused());
        vm.expectRevert("Pausable: paused");
        token.transfer(address(0x1), 1000);
    }
    function testUnpause() public {
        token.pause();
        token.unpause();
        assertFalse(token.paused());
        token.transfer(address(0x1), 1000);
        assertEq(token.balanceOf(address(0x1)), 1000);
    }
    /*BURN TEST*/
    function testBurn() public {
        uint256 amount = 1000;
        token.burn(amount);
        assertEq(token.balanceOf(address(this)), token.totalSupply() - amount);
        assertEq(token.totalSupply(), 1000000 * 10 ** token.decimals() - amount);
    }
}