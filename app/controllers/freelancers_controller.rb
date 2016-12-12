class FreelancersController < ApplicationController
    
    def show
        scrape_freelancer_details    
    end
    
protected
    def scrape_freelancer_details
        # Set the freelancer URL to scrape use Nokogiri to parse the data
        url = "https://www.atlasreactorgame.com/en/character/#{params[:id]}/"
        doc = Nokogiri::HTML(open(url))
        
        # Store the character data in an instance variable @char_data
        @char_data = Hash.new()
        
        # Scrape images from the page
        @char_data[:ability_img] = "//webcdn.triongames.com/ar/assets/images/char/abilities/abilities_lockwood.png"
        @char_data[:full_img] = doc.css('.bg-mobile-container').to_s.sub(/(.*)(?:url\()/, "").sub(/\);(.*)/, "")
        
        # Scrape character details
        @char_data[:name] = doc.css('#Character_Header_Name').text
        @char_data[:desc] = doc.css('.char-desc').text
        @char_data[:role] = doc.css('.char-bio').first.text.capitalize
        @char_data[:faction] = doc.css('.char-bio').last.text.capitalize
        
        # Scrape character ability data 
        ability_info = doc.css('.character-ability-info')
        x = 0
        @char_data[:ability] = Array.new()
        ability_info.each do |ab_info|
            x+=1
            # Ability name data
            @char_data[:ability][x] = Hash.new()
            @char_data[:ability][x][:name] = ab_info.at_css('h3').text
        end
        
    end
end