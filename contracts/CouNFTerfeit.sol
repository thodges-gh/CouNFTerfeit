// SPDX-License-Identifier: MIT
pragma solidity 0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./INFT.sol";

contract CouNFTerfeit is ERC721 {
  struct Original {
    address target;
    uint256 tokenId;
  }

  uint256 private _index;
  mapping(uint256 => Original) private _originals;
  mapping(address => mapping(uint256 => uint256)) public copies;

  constructor(
    string memory _name,
    string memory _symbol
  )
    ERC721(_name, _symbol)
  {}

  function mint(
    address _target,
    uint256 _tokenId
  )
    external
  {
    require(_target != address(0), "invalid target");
    uint256 _next = _index++;
    _originals[_next] = Original(_target, _tokenId);
    copies[_target][_tokenId]++;
    _safeMint(msg.sender, _next, "");
  }

  function tokenURI(
    uint256 _tokenId
  )
    public
    view
    override
    returns (string memory)
  {
    Original memory original = _originals[_tokenId];
    return INFT(original.target).tokenURI(original.tokenId);
  }
}
