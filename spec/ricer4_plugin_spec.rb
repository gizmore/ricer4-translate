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
    
    # Unknown language auto translate to user
#    expect(bot.exec_line_for("Translate/Translate", "aa de hallo")).to eq("msg_translated:{\"from\":\"de\",\"to\":\"en\",\"text\":\"aa de hello\"}")
    
  end
  
  it("can even do japanese to german for orrisan") do
    expect(bot.exec_line_for("Translate/Translate", "de ja Guten Morgen")).to eq("msg_translated:{\"from\":\"de\",\"to\":\"ja\",\"text\":\"おはよう\"}")
  end
  
  it("can enable the interpreter on a per user basis and auto translate every line") do
    expect(bot.exec_line_for("Translate/Interpreter")).to start_with("msg_status:{\"onoff\":")
    expect(bot.exec_line_for("Translate/Interpreter", "es,fr,de")).to eq("msg_enabled:{\"isos\":\"es,fr,de\"}")

    expect(bot.exec_line("Hallo Du hübscher")).to eq("msg_enabled:{\"isos\":\"es,fr,de\"}")
    
    
  end
  
  
end
