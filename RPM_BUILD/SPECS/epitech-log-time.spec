Name:           epitech-log-time
Version:        0.1.0
Release:        1%{?dist}
Summary:        An offline logtime calculator for Epitech
BuildArch:      noarch

License:        GPL3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
An offline logtime calculator for Epitech

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT%{_datadir}/epitech-log-time
install -m 777 detect_nw_activity.sh $RPM_BUILD_ROOT%{_datadir}/epitech-log-time/detect_nw_activity.sh
install -m 777 log_on_shutdown $RPM_BUILD_ROOT%{_datadir}/epitech-log-time/log_on_shutdown
mkdir -p $RPM_BUILD_ROOT%{_exec_prefix}/lib/systemd/system
install -m 666 logonstop.service $RPM_BUILD_ROOT%{_exec_prefix}/lib/systemd/system/logonstop.service
(crontab -l 2>/dev/null || true; echo "@reboot sh /home/$USER/.autorun/detect_nw_activity.sh &") | crontab -
crontab -r
(crontab -l 2>/dev/null || true; echo "@reboot sh /home/$USER/.autorun/detect_nw_activity.sh &") | crontab -
sudo crontab -n $(id -nu 1000)
sudo install -m 666 logonstop.service %{_exec_prefix}/lib/systemd/system/logonstop.service
sudo systemctl enable crond
sudo systemctl enable logonstop
sudo systemctl daemon-reload
touch logtime.log
install -m 666 logtime.log $RPM_BUILD_ROOT%{_datadir}/epitech-log-time/logtime.log

%files
%{_datadir}/epitech-log-time/logtime.log
%{_datadir}/epitech-log-time/log_on_shutdown
%{_datadir}/epitech-log-time/detect_nw_activity.sh
%{_exec_prefix}/lib/systemd/system/logonstop.service


%changelog
* Tue Dec 13 2022 Louis Dupraz <louis.dupraz@epitech.eu>
- 0.1.0
