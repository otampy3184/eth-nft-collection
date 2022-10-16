// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";
import "../node_modules/hardhat/console.sol";

contract NFTCollection is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract.");
    }

    // SVGコードを作成するためのベース
    string baseSvg =
        "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    string[] firstWords = [
        "city",
        "brand",
        "moon",
        "manage",
        "predator",
        "limited",
        "sin"
    ];
    string[] secondWords = [
        "isolation",
        "notice",
        "discreet",
        "exhibition",
        "office",
        "brag"
    ];
    string[] thirdWords = [
        "disaster",
        "team",
        "reveal",
        "detector",
        "grandmother",
        "interactive",
        "splurge"
    ];

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    //firstwordsの配列からランダムなWordを選ぶ
    function pickRandomFirstWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // 乱数生成からランダムな数字を生成し、配列番号に入れて返す
        uint256 rand = random(
            string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
        );
        console.log("rand seed:", rand);
        rand = rand % firstWords.length;
        console.log("rand first word:", rand);

        return firstWords[rand];
    }

    //secondwordsの配列からランダムなWordを選ぶ
    function pickRandomSecondWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // pickRandomSecondWord 関数のシードとなる rand を作成します。
        uint256 rand = random(
            string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId)))
        );
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    //thirdwordsの配列からランダムなWordを選ぶ
    function pickRandomThirdWord(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        // pickRandomThirdWord 関数のシードとなる rand を作成します。
        uint256 rand = random(
            string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId)))
        );
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function makeNFT() public {
        uint256 newTokenId = _tokenIds.current();

        // 一意の数newTokenIdを使ってランダムな文字群を取得する
        string memory first = pickRandomFirstWord(newTokenId);
        string memory second = pickRandomSecondWord(newTokenId);
        string memory third = pickRandomThirdWord(newTokenId);

        // 3つの単語を連結させ、SVGファイルを作成する
        string memory finalSvg = string(
            abi.encodePacked(baseSvg, first, second, third, "</text></svg>")
        );

        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, "We will set tokenURI later.");

        console.log("NFT w/ %s has been minted to %s", newTokenId, msg.sender);

        _tokenIds.increment();
    }
}
