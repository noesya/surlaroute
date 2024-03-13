# == Schema Information
#
# Table name: projects
#
#  id                                         :uuid             not null, primary key
#  description                                :text
#  image_alt                                  :string
#  image_credit                               :string
#  name                                       :string
#  published                                  :boolean          default(FALSE)
#  slug                                       :string           indexed
#  step0_ecodesign_time                       :boolean          default(FALSE)
#  step0_ecodesign_time_text                  :text
#  step0_low_tech                             :boolean          default(FALSE)
#  step0_low_tech_text                        :text
#  step0_sustainable_program                  :boolean          default(FALSE)
#  step0_sustainable_program_text             :text
#  step1_local_materials                      :boolean          default(FALSE)
#  step1_local_materials_text                 :text
#  step1_recycled_materials                   :boolean          default(FALSE)
#  step1_recycled_materials_text              :text
#  step1_reusable_materials                   :boolean          default(FALSE)
#  step1_reusable_materials_text              :text
#  step2_components_reduced_amount            :boolean          default(FALSE)
#  step2_components_reduced_amount_text       :text
#  step2_dismountable                         :boolean          default(FALSE)
#  step2_dismountable_text                    :text
#  step2_renewable_energy                     :boolean          default(FALSE)
#  step2_renewable_energy_text                :text
#  step3_matter_reduced_amount                :boolean          default(FALSE)
#  step3_matter_reduced_amount_text           :text
#  step4_artists_travel_optimization          :boolean          default(FALSE)
#  step4_artists_travel_optimization_text     :text
#  step4_separate_packaging                   :boolean          default(FALSE)
#  step4_separate_packaging_text              :text
#  step4_transport_sharing                    :boolean          default(FALSE)
#  step4_transport_sharing_text               :text
#  step5_energy_efficient                     :boolean          default(FALSE)
#  step5_energy_efficient_text                :text
#  step5_low_power_consumption                :boolean          default(FALSE)
#  step5_low_power_consumption_text           :text
#  step5_public_area_sorting                  :boolean          default(FALSE)
#  step5_public_area_sorting_text             :text
#  step5_public_awareness                     :boolean          default(FALSE)
#  step5_public_awareness_text                :text
#  step5_water_efficient                      :boolean          default(FALSE)
#  step5_water_efficient_text                 :text
#  step5_zero_waste                           :boolean          default(FALSE)
#  step5_zero_waste_text                      :text
#  step6_extended_lifetime                    :boolean          default(FALSE)
#  step6_extended_lifetime_text               :text
#  step7_closed_loop_recycling                :boolean          default(FALSE)
#  step7_closed_loop_recycling_text           :text
#  step7_composted_materials                  :boolean          default(FALSE)
#  step7_composted_materials_text             :text
#  step7_disassembly_five_stream_sorting      :boolean          default(FALSE)
#  step7_disassembly_five_stream_sorting_text :text
#  created_at                                 :datetime         not null
#  updated_at                                 :datetime         not null
#  published_by_id                            :uuid             indexed
#
# Indexes
#
#  index_projects_on_published_by_id  (published_by_id)
#  index_projects_on_slug             (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_fef370b0dc  (published_by_id => users.id)
#
class Project < ApplicationRecord
  FIELDS = [
    # 0
    [
      :step0_sustainable_program,
      :step0_low_tech,
      :step0_ecodesign_time
    ],
    # 1
    [
      :step1_local_materials,
      :step1_recycled_materials,
      :step1_reusable_materials
    ],
    # 2
    [
      :step2_components_reduced_amount,
      :step2_dismountable,
      :step2_renewable_energy
    ],
    # 3
    [
      :step3_matter_reduced_amount
    ],
    # 4
    [
      :step4_artists_travel_optimization,
      :step4_separate_packaging,
      :step4_transport_sharing
    ],
    # 5
    [
      :step5_energy_efficient,
      :step5_low_power_consumption,
      :step5_public_area_sorting,
      :step5_public_awareness,
      :step5_water_efficient,
      :step5_zero_waste
    ],
    # 6
    [
      :step6_extended_lifetime
    ],
    # 7
    [
      :step7_closed_loop_recycling,
      :step7_composted_materials,
      :step7_disassembly_five_stream_sorting
    ]
  ]

  include Commentable
  include Favoritable
  include Publishable
  include Regional
  include Slugged
  include Structured
  include WithBrezetWheel

  has_and_belongs_to_many :actors
  has_and_belongs_to_many :materials
  has_and_belongs_to_many :technics
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  has_one_attached_deletable :image

  validates_presence_of :name

  scope :ordered, -> { order(:name) }

  scope :autofilter, -> (parameters) { ::Filters::Autofilter.new(self, parameters).filter }
  scope :autofilter_search, -> (term) {
    where("unaccent(materials.name) ILIKE unaccent(:term)", term: "%#{sanitize_sql_like(term)}%")
  }

  def self.fields_for_step(step)
    FIELDS[step]
  end

  def to_s
    "#{name}"
  end
end
