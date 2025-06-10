class MigrateActorMaterials < ActiveRecord::Migration[7.1]
  def change
    # Useless migration for Sur la route, no data
    # Material.where.not(actor_id: nil).each do |material|
    #   material.actors << Actor.find(material.actor_id)
    # end
  end
end
