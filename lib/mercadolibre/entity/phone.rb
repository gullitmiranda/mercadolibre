module Mercadolibre
  module Entity
    class Phone
      def self.attr_list
        [:area_code, :number, :extension]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          self.send("#{k}=", v) if self.respond_to?(k)
        end
      end

      def to_s
        phone = [self.area_code, self.number].join.gsub /[^0-9]/, ""
        phone << "-#{self.extension}" unless self.extension.nil?
        phone.to_s
      end

      private

      attr_writer *attr_list
    end
  end
end
