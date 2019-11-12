# Set SELinux type to permissive
#
# @param ensure Set to present to add or absent to remove a permissive mode of a type
# @param seltype A particular selinux type to make permissive, like "oddjob_mkhomedir_t"
#
# @example Mark oddjob_mkhomedir_t permissive
#   vox_selinux::permissive { 'oddjob_mkhomedir_t':
#     ensure => 'present'
#   }
#
define vox_selinux::permissive (
  String $seltype = $title,
  Enum['present', 'absent'] $ensure = 'present',
) {

  include vox_selinux
  if $ensure == 'present' {
    Anchor['vox_selinux::module post']
    -> Vox_selinux::Permissive[$title]
    -> Anchor['vox_selinux::end']
  } else {
    Anchor['vox_selinux::start']
    -> Vox_selinux::Permissive[$title]
    -> Anchor['vox_selinux::module pre']
  }

  selinux_permissive {$seltype:
    ensure => $ensure,
  }
}
