
//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.8.7; 
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol"; 
/* LFG My address is whalegoddess.eth. */ 
contract RefundContract is Ownable, Pausable { 
    address private DEAD = 0x000000000000000000000000000000000000dEaD; 
    address token;
    constructor (address _address) {
        token = _address;
     } 
    function refund(uint256[] memory _tokenIds) public payable whenNotPaused { 
        for(uint256 i=0; i<_tokenIds.length; i++){
            require(IERC721(token).ownerOf(_tokenIds[i]) == msg.sender, "sender does not own NFT"); 
            IERC721(token).transferFrom(msg.sender, DEAD, _tokenIds[i]); 
        }
        
        payable(msg.sender).transfer(.079 ether * _tokenIds.length); 
        } 
        function withdrawAll() public payable onlyOwner { 
            uint256 bal = address(this).balance; payable(msg.sender).transfer(bal); 
            } 
            event FundsReceived(uint256 amount); 
            receive() payable external { emit FundsReceived(msg.value); }}
