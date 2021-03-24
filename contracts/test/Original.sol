// SPDX-License-Identifier: MIT
pragma solidity 0.8.3;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Original is ERC721 {
  uint256 private _index;

  constructor(
    string memory _name,
    string memory _symbol
  )
    ERC721(_name, _symbol)
  {}

  function mint()
    external
  {
    _safeMint(msg.sender, _index++, "");
  }

  function _baseURI()
    internal
    pure
    override
    returns (string memory)
  {
    return "https://example.com/";
  }
}
