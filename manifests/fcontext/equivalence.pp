# Manage SELinux fcontext equivalences
#
# @param path   the path to define and equivalence for. Default: Resource title
# @param target the path that this resource will be equivalent to.
# @param ensure the desired state of the equivalence. Default: present
#
# @example Make /opt/wordpress equivalent to /usr/share/wordpress
#   vox_selinux::fcontext::equivalence { '/opt/wordpress':
#     ensure => 'present',
#     target => '/usr/share/wordpress',
#   }
#
define vox_selinux::fcontext::equivalence(
  String $target,
  String $path = $title,
  Enum['present', 'absent'] $ensure = 'present'
) {

  include vox_selinux

  if $ensure == 'present' {
    Anchor['vox_selinux::module post']
    -> Vox_selinux::Fcontext::Equivalence[$title]
    -> Anchor['vox_selinux::end']
  } else {
    Anchor['vox_selinux::start']
    -> Vox_selinux::Fcontext::Equivalence[$title]
    -> Anchor['vox_selinux::module pre']
  }

  selinux_fcontext_equivalence { $path:
    ensure => $ensure,
    target => $target,
  }
}

