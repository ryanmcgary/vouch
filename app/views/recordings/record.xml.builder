xml.instruct!
xml.Response do    
    xml.Say "Please leave a review, Press 1 to finish recording and review your message"
    xml.Record(:action => @trunk, :method => "post", :maxLength => 60, :finishOnkey => 1)
    xml.Say "I couldn't hear anything"
    xml.Redirect @record
end
