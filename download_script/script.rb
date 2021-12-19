require 'webdrivers'
require 'watir'
require './config'

prefs = {
  download: {
    'prompt_for_download' => false,
    'default_directory' => DownloadConfig::CONFIG[:download_directory]
  },
  plugins: {
    'always_open_pdf_externally' => true
  }
}

browser = Watir::Browser.new :chrome, options: {prefs: prefs}

browser.goto DownloadConfig::CONFIG[:lego_url]

age_gate = browser.element(class: 'AgeGatestyles__Wrapper-xudtvj-0').wait_until(&:exists?)
age_gate_button = browser.element(class: ['Button__Base-sc-1jdmsyi-0', 'eLFkVi AgeGatestyles__StyledButton-xudtvj-12', 'hycfPw'])
age_gate_button.click

cookie_gate = browser.element(class: ['Modalstyles__ModalWindow-l3z049-1', 'ivppUQ']).wait_until(&:exists?)
cookie_gate_button = browser.element(class: ['Button__Base-sc-1jdmsyi-0 aKFCv CookieModalstyles__PrimaryButton-sc-19wlthm-7', 'fzEDYJ'])
cookie_gate_button.click

search_box = browser.text_field(id: 'search')
search_box.set '75300'

search_button = browser.button(class: ['c-form-item__icon', 'c-btn', 'c-btn--silent'])
search_button.click

instruction_result = browser.element(id: '75300').wait_until(&:exists?)
instruction_result_link = browser.element(class: ['c-card__img', 'o-inline-img', 'o-inline-img--contain', 'o-inline-img--inset', 'c-btn', 'o-ratio', 'o-ratio--four-three', 'o-ratio--fit-vert'])
instruction_result_link.click

download_link = browser.element(class: ['c-card', 'c-card--bi-list']).wait_until(&:exists?)
download_link.click

sleep(10)

browser.close
