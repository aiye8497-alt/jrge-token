//SPDX-LICENSE-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/tokens/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20PAUSEABLE.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JrgeToken is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    constructor() ERC20("JrgeToken", "JRGE") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
    