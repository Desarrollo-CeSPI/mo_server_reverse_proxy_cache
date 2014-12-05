def varnish_port
  node['varnish']['listen_port']
end

def varnish_ip
  node['varnish']['listen_address']
end

def applications_for(vhost)
  apps = []
  vhost.last["applications"].each do |a|
    app = Hash.new
    app[:name] = a[0]
    app[:server_name] = a[1]["server_name"]
    app[:listen] = a[1]["listen"]
    app[:ssl] = a[1]["ssl"]
    apps << app
  end
  apps
end

def ssl_for(app)
  if app[:ssl]['enabled']
    ({'public' => "-----BEGIN CERTIFICATE-----\nMIIDrDCCApQCCQC7CxLJh0C07TANBgkqhkiG9w0BAQUFADCBlzELMAkGA1UEBhMC\nVVMxEDAOBgNVBAgMB1NldmVyYWwxETAPBgNVBAcMCExvY2FsaXR5MRQwEgYDVQQK\nDAtFeGFtcGxlIENvbTETMBEGA1UECwwKT3BlcmF0aW9uczEYMBYGA1UEAwwPd3d3\nLnVubHAuZWR1LmFyMR4wHAYJKoZIhvcNAQkBFg9vcHNAZXhhbXBsZS5jb20wHhcN\nMTQxMjA1MTk0ODQ3WhcNMjQxMjAyMTk0ODQ3WjCBlzELMAkGA1UEBhMCVVMxEDAO\nBgNVBAgMB1NldmVyYWwxETAPBgNVBAcMCExvY2FsaXR5MRQwEgYDVQQKDAtFeGFt\ncGxlIENvbTETMBEGA1UECwwKT3BlcmF0aW9uczEYMBYGA1UEAwwPd3d3LnVubHAu\nZWR1LmFyMR4wHAYJKoZIhvcNAQkBFg9vcHNAZXhhbXBsZS5jb20wggEiMA0GCSqG\nSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmuLPyziYeNpgYTEQINunsSPTEl6kHxnMS\nh7x66fKHdPxGie0IXxgb8laekpfsF5GEAaagjK7hbxy6aak3GmOtQk4NTeVEnmj0\nMtmJmLQrZnSZ3CKsx8EH7dr3WCSCSk0YVkMfFXAZmGsSp5XkLDHOcn5BIO0EuLdI\nfSpZUtJ8VLJHrpDUti9AyKThFAHn+uYhRT3eSrk0fipThb+IK/R/qjEfdg2bfaq1\nlF97wgHI5HFvWwd/xTfoEArbuGwuazdYjlA9NXUzaOtYOSPN6MxmH+qgOnVI44i2\n8bUgOanItR/6/5KMnKW51gVdkKaQMgtFh/ZuZ7c5hsx8x7IUPQ/5AgMBAAEwDQYJ\nKoZIhvcNAQEFBQADggEBAN3SET2bFDuaz8EXhtqFZDeQhQ0M+boNNnwsejg6mltm\ngQaiV5/5psD/eLHzF8koJ0+q+mPX9YWU8uk9b49jY3bes4fkVIVHZfGyf1ruAkEy\n6of19qc2f6wblt4q9aQP+1RslGixK+v0knyBmLgwLzudl21r/ZuN6cIzUIrXkZKq\n4xyxs23v4n3YjuIc+5ugXVwbdlpAYNrWWLqbO8qjKh8Zh7YXj9f8fFRr9tz2ytrG\nzFf8ilkKhrkzgiFvEjOPFsKlnmKUULcpK03xB+1kfvt00W/xyL+hN3g0wPpVV+i2\ntCzv4WoQMBjgvVx6AOPLSPbX8r5GRRnnpJpADX2098U=\n-----END CERTIFICATE-----\n",
      'private' => "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA5riz8s4mHjaYGExECDbp7Ej0xJepB8ZzEoe8eunyh3T8Ront\nCF8YG/JWnpKX7BeRhAGmoIyu4W8cummpNxpjrUJODU3lRJ5o9DLZiZi0K2Z0mdwi\nrMfBB+3a91gkgkpNGFZDHxVwGZhrEqeV5CwxznJ+QSDtBLi3SH0qWVLSfFSyR66Q\n1LYvQMik4RQB5/rmIUU93kq5NH4qU4W/iCv0f6oxH3YNm32qtZRfe8IByORxb1sH\nf8U36BAK27hsLms3WI5QPTV1M2jrWDkjzejMZh/qoDp1SOOItvG1IDmpyLUf+v+S\njJyludYFXZCmkDILRYf2bme3OYbMfMeyFD0P+QIDAQABAoIBAQCjBAPY3YEfPdGu\n8UvsReh304Bl2wZKARRTFma8rcl3ndeVe2Rn0tC1Bj/fYJJI9MoS7BuwOlZh3+D7\ncSZnUZT12PBPBCemmQps5/S9/I/oTka6Y0h4rdacZJmew79f82GPfXuFXd9Lpl6Y\n2qHUislSJaFBISN2f5C4ff9LB3LC9rkDR7AjMNBvuNTjL2fDjuodK6S//OUf1srH\nU/2fg2wBLyBYUWR9mqFfVA2sFmD24Jj8D0pOS0FumKKLpoepEHnjVKcyvDtaYHCR\njkNPKOsjXwu583ZNfKZKYbLTAt9oaj33y6ydwutstcv94pBQCa4zYPWixD7lc2MO\nL6cni1zlAoGBAP7MAyijB7tsNEEhODUA0uyDiNaYrLUYS+1oQRs4S6hdVBb/fX+e\ntYc+Wm78dv+a5Sdr5+2SAVUfDJlBcEKClyo/3M932i5Yzotle6MSA7o98SeUF/kC\nVIImdgkyqW3ieM/LBVMja0ivBsnbv4/U9DVC89B8dT+Z0K8F8khqI4NrAoGBAOfP\nltgPRDTmvrlXsBYbWPiSHy1XFucnK7/iaaOlU0nhcmfFZHZPAeVCMxWCmrU8vot+\n4l9i6YrcG9XBqVHqdIHACjeGwoLXSXsv/I/35R/jaAa0uLpsJcvW//xJhvRp2bb6\nz7QBfwWo62nFmAWbK5+i5/ShwYqYEytFeIJJnjcrAoGAVH2KPptxIPFMkpxVax4O\n02b6pU6TVqnr45nCnSgZzobEL6whDYSvZV2D13HYdAIFIwFhMyJLVtKo9tkARM3R\nGq16p0FzFBNWylqomPaMTeHkad9t46CmLVJbqckm7c0/iogkB+Gi3cNMWPuJlkRj\nhpXhC615o9F5pdAu+1xW0mkCgYAcogCQ2XnkSugd/p3KbUBVG79sG0jB7o2x2uaP\nhxk9k/JMrQ4WqvWh+sZSjtpLLqCenGKbw5zzQPLTOWOPsbUIXc8lQqj9/leeNrQs\nmEMd6DnuMh5rMHaOshTWdcKMqBJzTpGfO1wUN+Q0IWsArkT6J+Ycymock2Iywxb6\niNtZFwKBgQDthqwmyCWJwUrjwvbZcYaFGJdqV0PQpV02hbLCn+P86msDrAgmwnX2\n/ZiMAPQ+l6BOyChQ7BN+exTH6pzjYwFzIarlK1i2/0v/mzCSgahef6HjhvuXPr55\n5CxBWOIIzIHYMapnZHmoxxgfVWEQRmJv8lmr34EO5CDLq+wf8zRgAg==\n-----END RSA PRIVATE KEY-----\n"})
  end
end
