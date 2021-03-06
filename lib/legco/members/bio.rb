# encoding: utf-8

require 'mechanize'
require 'nokogiri'
require 'open-uri'

module Legco
  module Members
    class Bio
      def chinese
        a = Mechanize.new
        a.get('http://www.legco.gov.hk/general/chinese/members/index.html') do |page|
          a.click(page.link_with(:text => %r{議員履歷}))
        end

        doc = a.page
        base_url = doc.uri.to_s
        doc.search(".bio-member-info").collect do |node|
          image = node.search("img/@src").text rescue nil
          member_node = node.search("strong a").first
          constituency =node.search(".size2").text.strip[1..-3] rescue nil

          if member_node
            url = member_node.attribute("href").text
            name = member_node.text.strip[/^(.+)議員.*/, 1] rescue nil
          end

          if url
            qualifications = []
            jobs = []
            parties = []
            address = nil
            temp = nil
            telephone = []
            fax = []
            email = nil
            website = nil
            url = to_absolute(base_url, url)

            page = Nokogiri::HTML(open(url))

            content = page.search("#container")
            uls = content.search("//ul")
            uls[1].search("li").each do |li|
              qualifications.push(li.text.strip)
            end

            uls[2].search("li").each do |li|
              jobs.push(li.text.strip)
            end

            if (uls.size >= 4)
              uls[3].search("li").each do |li|
                parties.push(li.text.strip)
              end
            end

            content = page.search("#_content_")
            content.search("//table//tr").each do |tr|
              case tr.search("td[1]").text
              when "辦事處地址"
                address = tr.search("td[3]").text.strip
              when "辦事處電話"
                telephone = tr.search("td[3]").text.strip.split("/").collect {|phone| phone.delete(' ')}
              when "辦事處傳真"
                fax = tr.search("td[3]").text.strip.split("/").collect {|fax| fax.delete(' ')}
              when "電郵"
                email = tr.search("td[3]").text.strip
              when "網頁"
                website = tr.search("td[3]").text.strip
              end
            end
          end

          if image && name && url && constituency
            {
              name: name,
              image: to_absolute(base_url, image),
              url: url,
              constituency: constituency,
              qualifications: qualifications,
              jobs: jobs,
              parties: parties,
              address: address,
              telephone: telephone,
              fax: fax,
              email: email,
              website: website
            }
          else
            nil
          end
        end.compact
      end

      def english
        a = Mechanize.new
        a.get('http://www.legco.gov.hk/general/english/members/index.html') do |page|
          a.click(page.link_with(:text => %r{Members' Biographies}))
        end

        doc = a.page
        base_url = doc.uri.to_s
        doc.search(".bio-member-info").collect do |node|
          image = node.search("img/@src").text rescue nil
          member_node = node.search("strong a").first
          constituency =node.search(".size2").text.strip[1..-3] rescue nil

          if member_node
            url = member_node.attribute("href").text
            name = member_node.text.strip[/^[Hon |Prof |Dr ]*([A-Za-z -]*)/, 1] rescue nil
          end

          if url
            qualifications = []
            jobs = []
            parties = []
            address = nil
            temp = nil
            telephone = []
            fax = []
            email = nil
            website = nil
            url = to_absolute(base_url, url)

            page = Nokogiri::HTML(open(url))

            content = page.search("#container")
            uls = content.search("//ul")
            uls[1].search("li").each do |li|
              qualifications.push(li.text.strip)
            end

            uls[2].search("li").each do |li|
              jobs.push(li.text.strip)
            end

            if (uls.size >= 4)
              uls[3].search("li").each do |li|
                parties.push(li.text.strip)
              end
            end

            content = page.search("#_content_")
            content.search("//table//tr").each do |tr|
              case tr.search("td[1]").text
              when "Office address"
                address = tr.search("td[3]").text.strip
              when "Office telephone"
                telephone = tr.search("td[3]").text.strip.split("/").collect {|phone| phone.delete(' ')}
              when "Office fax"
                fax = tr.search("td[3]").text.strip.split("/").collect {|fax| fax.delete(' ')}
              when "E-mail"
                email = tr.search("td[3]").text.strip
              when "Homepage"
                website = tr.search("td[3]").text.strip
              end
            end
          end

          if image && name && url && constituency
            {
              name: name,
              image: to_absolute(base_url, image),
              url: url,
              constituency: constituency,
              qualifications: qualifications,
              jobs: jobs,
              parties: parties,
              address: address,
              telephone: telephone,
              fax: fax,
              email: email,
              website: website
            }
          else
            nil
          end
        end.compact
      end

      def to_absolute(root, href)
        URI.join(root, href).to_s
      end
    end
  end
end
