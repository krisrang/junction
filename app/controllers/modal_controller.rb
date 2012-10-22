class ModalController < ApplicationController
  after_filter :set_expires
end
