require 'spec_helper'

describe Ricer4::Plugins::Translate do
  
  # LOAD
  bot = Ricer4::Bot.new("ricer4.spec.conf.yml")
  bot.db_connect
  ActiveRecord::Magic::Update.install
  ActiveRecord::Magic::Update.run
  bot.load_plugins
  ActiveRecord::Magic::Update.run

  it("detects languages as parameters and translates on demand") do
    
    # Do it twice to detect hook problems
    expect(bot.exec_line_for("Translate/Translate", "en de hello")).to eq('msg_translated:{"from":"en","to":"de","text":"Hallo"}')
    expect(bot.exec_line_for("Translate/Translate", "en de hello")).to eq('msg_translated:{"from":"en","to":"de","text":"Hallo"}')
    
    # 
    expect(bot.exec_line_for("Translate/Translate", "aa de hello")).to eq('msg_translated:{"from":"en","to":"de","text":"Hallo"}')

  end
  
end
