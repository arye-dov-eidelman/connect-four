describe "bin/connectfour" do
  it 'instantiates an instance of ConnectFour' do
    game = ConnectFour.new
    allow($stdout).to receive(:puts)
    allow(game).to receive(:play)
    allow(game).to receive(:gets).and_return("1")

    expect(ConnectFour).to receive(:new).and_return(game)

    run_file("./bin/connectfour")
  end

  it 'calls #play on the instance of ConnectFour' do
    game = ConnectFour.new
    allow($stdout).to receive(:puts)

    expect(ConnectFour).to receive(:new).and_return(game)
    expect(game).to receive(:play)
    run_file("./bin/connectfour")
  end
end
