require 'webdrivers'
require 'watir'
require './config'
require 'optimist'

opts = Optimist::options do
    opt :sets, "Lego sets", :type => :string
end

abort("Must provide --sets with space seperated list of set ID's") if !opts[:sets]

p opts[:sets].split

opts[:sets].split.each do |set|
  p set

  prefs = {
    download: {
      'prompt_for_download' => false,
      'default_directory' => "#{DownloadConfig::CONFIG[:download_directory]}/#{set}"
    },
    plugins: {
      'always_open_pdf_externally' => true
    }
  }

  p "#{DownloadConfig::CONFIG[:download_directory]}/#{set}"

  browser = Watir::Browser.new :chrome, options: {prefs: prefs}

  browser.goto "https://www.lego.com/en-us/service/buildinginstructions/#{set}"

  age_gate = browser.element(class: 'AgeGatestyles__Wrapper-xudtvj-0').wait_until(&:exists?)
  age_gate_button = browser.element(class: ['Button__Base-sc-1jdmsyi-0', 'eLFkVi AgeGatestyles__StyledButton-xudtvj-12', 'hycfPw'])
  age_gate_button.click

  sleep(2)

  cookie_gate = browser.element(class: ['Modalstyles__ModalWindow-l3z049-1', 'ivppUQ']).wait_until(&:exists?)
  cookie_gate_button = browser.element(class: ['Button__Base-sc-1jdmsyi-0 aKFCv CookieModalstyles__PrimaryButton-sc-19wlthm-7', 'fzEDYJ'])
  cookie_gate_button.click

  sleep(2)

  begin
    survey_gate_button = browser.element(id: 'noButton').wait_until(timeout: 4, &:exists?)
    survey_gate_button.click
  rescue Watir::Wait::TimeoutError
    p "Caught a timeout error"
  end

  p 'we reached here!'
  sleep(2)
  download_link = browser.element(class: ['c-card', 'c-card--bi-list']).wait_until(&:exists?)
  download_link.click

  sleep(2)

  p download_link
  browser.close
end
