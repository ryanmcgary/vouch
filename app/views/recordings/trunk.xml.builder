xml.instruct!
xml.Response do
    xml.Gather(:action => @record, :numDigits => 1) do
        xml.Say "Please leave a review for speaker"
        xml.Say "Press 1 when you are ready to record your review. Press 9 to cancel. Hangup to disconnect."  
    end                                                                                               
    xml.Redirect @trunk 
end