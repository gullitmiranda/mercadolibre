module Mercadolibre
  module Entity
    class OrderItem
      def self.attr_list
        [:currency_id, :item_id, :item_title, :quantity, :unit_price]
      end

      attr_reader *attr_list

      def initialize(attributes={})
        attributes.each do |k, v|
          if k.to_s == 'item'
            self.item_id = v['id']
            self.item_title = v['title']
          else
            self.send("#{k}=", v) if self.respond_to?(k)
          end
        end
      end

      def to_hash
        hash = {}

        self.class.attr_list.map do |k|
          if self.respond_to?(k)
            value = self.send(k)
            value = value.to_hash if value.respond_to? :to_hash
          else
            value = nil
          end

          hash[k] = value unless value.nil?
        end
        hash
      end

      private

      attr_writer *attr_list
    end
  end
end
