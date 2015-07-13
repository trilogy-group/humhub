[Back to 0.20 Migration](dev-migrate-0.20.md)

# HumHub 0.20 - Status

## Open 

- Theming
	- Themed Image files User/Space Default Profile Image
	- Notification/Activity Mail Views
- Integritychecker
- Caching
	- HSetting
	- UserModel: CanApproveUsers
- Url Rewriting (User)
- LDAP 

## Bugs / ToDos / To Improve

- Check Delete Related Record
- Check UserList Ajax Pagination

- Add ModuleId to Notifications
- Use own Namespaces for Modules not module/
- Delete config.php Cache on Error / Don't config Cache on DEV!
- Modal Confirm doesn't disappear
- Comment in new Window Mode / Like Link in Modules

- Check how to handle unapproved/disabled users (Directory, Spaces)
	ActiveQuery User

- Test Paginations
	- Check/Fix Ajax Link Pager at like show users
- CSRF
- Registration Process
	- When Invited to a space (Notification & Co.)
- Check complexer Migrations
- Translation
	- try regenerate files
	- fix translation categories for changed FileNames
- Guest Mode
- User Approval

## Modules

### Migrated

- Wiki
- Calendar
- Custom Pages
- Mail
- Polls
- Tasks

### Open

- BreakingNews
- NewMembers
- Birthday
- MostActiveUsers
- Notes
- SMS

- Meeting
- Translation
- ReportContent
- LinkList
- Updater
- CV