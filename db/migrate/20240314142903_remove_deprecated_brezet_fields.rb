class RemoveDeprecatedBrezetFields < ActiveRecord::Migration[7.1]
  def change
    remove_column :projects, :step0_ecodesign_time, :boolean, default: false
    remove_column :projects, :step0_ecodesign_time_text, :text
    remove_column :projects, :step0_low_tech, :boolean, default: false
    remove_column :projects, :step0_low_tech_text, :text
    remove_column :projects, :step0_sustainable_program, :boolean, default: false
    remove_column :projects, :step0_sustainable_program_text, :text
    remove_column :projects, :step1_local_materials, :boolean, default: false
    remove_column :projects, :step1_local_materials_text, :text
    remove_column :projects, :step1_recycled_materials, :boolean, default: false
    remove_column :projects, :step1_recycled_materials_text, :text
    remove_column :projects, :step1_reusable_materials, :boolean, default: false
    remove_column :projects, :step1_reusable_materials_text, :text
    remove_column :projects, :step2_components_reduced_amount, :boolean, default: false
    remove_column :projects, :step2_components_reduced_amount_text, :text
    remove_column :projects, :step2_dismountable, :boolean, default: false
    remove_column :projects, :step2_dismountable_text, :text
    remove_column :projects, :step2_renewable_energy, :boolean, default: false
    remove_column :projects, :step2_renewable_energy_text, :text
    remove_column :projects, :step3_matter_reduced_amount, :boolean, default: false
    remove_column :projects, :step3_matter_reduced_amount_text, :text
    remove_column :projects, :step4_artists_travel_optimization, :boolean, default: false
    remove_column :projects, :step4_artists_travel_optimization_text, :text
    remove_column :projects, :step4_separate_packaging, :boolean, default: false
    remove_column :projects, :step4_separate_packaging_text, :text
    remove_column :projects, :step4_transport_sharing, :boolean, default: false
    remove_column :projects, :step4_transport_sharing_text, :text
    remove_column :projects, :step5_energy_efficient, :boolean, default: false
    remove_column :projects, :step5_energy_efficient_text, :text
    remove_column :projects, :step5_low_power_consumption, :boolean, default: false
    remove_column :projects, :step5_low_power_consumption_text, :text
    remove_column :projects, :step5_public_area_sorting, :boolean, default: false
    remove_column :projects, :step5_public_area_sorting_text, :text
    remove_column :projects, :step5_public_awareness, :boolean, default: false
    remove_column :projects, :step5_public_awareness_text, :text
    remove_column :projects, :step5_water_efficient, :boolean, default: false
    remove_column :projects, :step5_water_efficient_text, :text
    remove_column :projects, :step5_zero_waste, :boolean, default: false
    remove_column :projects, :step5_zero_waste_text, :text
    remove_column :projects, :step6_extended_lifetime, :boolean, default: false
    remove_column :projects, :step6_extended_lifetime_text, :text
    remove_column :projects, :step7_closed_loop_recycling, :boolean, default: false
    remove_column :projects, :step7_closed_loop_recycling_text, :text
    remove_column :projects, :step7_composted_materials, :boolean, default: false
    remove_column :projects, :step7_composted_materials_text, :text
    remove_column :projects, :step7_disassembly_five_stream_sorting, :boolean, default: false
    remove_column :projects, :step7_disassembly_five_stream_sorting_text, :text
  end
end
