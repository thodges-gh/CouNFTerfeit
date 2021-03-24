const chai = require('chai')
const { expect } = chai
const { solidity } = require('ethereum-waffle')
chai.use(solidity);

describe('CouNFTerfeit', () => {
  beforeEach(async () => {
    [...this.accounts] = await ethers.getSigners()
    const Original = await ethers.getContractFactory('Original')
    this.original = await Original.deploy('Original', 'NFT')
    await this.original.deployed()
    await this.original.mint()
    const CouNFTerfeit = await ethers.getContractFactory('CouNFTerfeit')
    this.nft = await CouNFTerfeit.deploy('CouNFTerfeit', 'CNFT')
    await this.nft.deployed()
  })

  describe('mint', () => {
    it('mints', async () => {
      await expect(this.nft.mint(this.original.address, 0))
        .to.emit(this.nft, 'Transfer')
        .withArgs(ethers.constants.AddressZero, this.accounts[0].address, 0)
      expect(await this.nft.tokenURI(0)).to.equal(await this.original.tokenURI(0))
    })
  })
})
