import pandas as pd

csv = pd.read_csv('https://omahaproxy.appspot.com/all')
csv = csv.filter(items = ['channel', 'v8_version'])
csv = csv.dropna()
csv = csv[csv['channel'] == 'stable']
versions = csv.v8_version.unique()

if len(versions) == 0:
	sys.exit('Version not found')

print(sorted(versions, key=lambda v: int(v.rsplit('.', 1)[1]), reverse=True)[0])