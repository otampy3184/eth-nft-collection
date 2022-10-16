// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/hardhat/console.sol";

contract NFTCollection is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    constructor() ERC721("NCollection", "CLLCT") {
        console.log("construct success");
    }

    function makeNFT() public {
        uint256 newTokenId = _tokenIds.current();

        _safeMint(msg.sender, newTokenId);

        _setTokenURI(newTokenId, "sample uri");

        console.log("NFT w/ %s has been minted to %s", newTokenId, msg.sender);

        _tokenIds.increment();
    }
}
