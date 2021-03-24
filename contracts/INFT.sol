// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface INFT {
  function tokenURI(uint256 _tokenId) external view returns (string memory);
}
