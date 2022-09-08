//SPDX-License-Identifier: MIT
pragma solidity >= 0.8;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetMinterPauser.sol";

/**
 * This Smart Contract implements a MultisigERC20 Token which can be minted, paused and capped,
 *   although the cap can be altered.
 * 
 */
contract ERC20FancyToken is ERC20PresetMinterPauser {

    uint256 private _cap;

    /**
     * @dev Grants `CAP_CHANGER_ROLE`, `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
     * account that deploys the contract.
     *
     * See {ERC20-constructor}.
     *
     * Sets the value of the `cap`.  This value can be altered later by the `CAP_CHANGER_ROLE`
     * 
     */
    constructor(string memory name, string memory symbol, uint256 cap_) ERC20PresetMinterPauser (name, symbol) {
        require(cap_ > 0, "ERC20Capped: cap is 0");
        _cap = cap_;
    }

  
    /**
     * @dev Returns the cap on the token's total supply.
     */
    function cap() public view virtual returns (uint256) {
        return _cap;
    }

    /**
     * @dev See {ERC20-_mint}.
     */
    function _mint(address account, uint256 amount) internal override {
        require(ERC20.totalSupply() + amount <= cap(), "ERC20Capped: cap exceeded");
        super._mint(account, amount);
    }
   
}