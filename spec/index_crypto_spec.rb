require_relative '../lib/index_crypto'

describe "crypto_scrapper method" do
    it "should return an array of hash" do
    expect(crypto_scrapper.class).to eq(Array)
end
    it "should return more than 2300 results" do
    expect(crypto_scrapper.size > 2300).to eq(true)
end
    it "should return a value for the first 3 symbols" do
    expect(crypto_scrapper[0].keys[0]).to eq("BTC")
    expect(crypto_scrapper[1].keys[0]).to eq("ETH")
    expect(crypto_scrapper[2].keys[0]).to eq("XRP")
end
end